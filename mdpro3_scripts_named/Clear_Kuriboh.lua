--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 洁净栗子球  (ID: 46613515)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 164
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：给与伤害的怪兽的效果由对方发动时，把这张卡从手卡丢弃才能发动。那个发动无效。
-- ②：对方怪兽的直接攻击宣言时，把墓地的这张卡除外才能发动。自己从卡组抽1张。那张抽到的卡是怪兽的场合，可以再把那只怪兽特殊召唤。那之后，攻击对象转移为那只怪兽。
--[[ __CARD_HEADER_END__ ]]

--クリアクリボー
function c46613515.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46613515,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c46613515.negcon)
	e1:SetCost(c46613515.negcost)
	e1:SetTarget(c46613515.negtg)
	e1:SetOperation(c46613515.negop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46613515,1))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,46613515)
	e2:SetCondition(c46613515.drcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c46613515.drtg)
	e2:SetOperation(c46613515.drop)
	c:RegisterEffect(e2)
end
function c46613515.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and (aux.damcon1(e,tp,eg,ep,ev,re,r,rp) or aux.damcon1(e,1-tp,eg,ep,ev,re,r,rp))
		and re:IsActiveType(TYPE_MONSTER) and ep~=tp
end
function c46613515.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c46613515.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c46613515.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function c46613515.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c46613515.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c46613515.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsType(TYPE_MONSTER) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(46613515,2)) then
			Duel.ConfirmCards(1-tp,tc)
			Duel.BreakEffect()
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 and not Duel.GetAttacker():IsImmuneToEffect(e) then
				Duel.BreakEffect()
				Duel.ChangeAttackTarget(tc)
			end
		end
	end
end
