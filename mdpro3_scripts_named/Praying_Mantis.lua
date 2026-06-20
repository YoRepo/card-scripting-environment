--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 合掌螳螂  (ID: 31600513)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己准备阶段才能发动。在自己场上把1只「小螳螂衍生物」（昆虫族·风·1星·攻/守500）特殊召唤。
-- ②：1回合1次，对方怪兽的攻击宣言时，把自己的魔法与陷阱区域1张卡送去墓地才能发动。那只对方怪兽回到持有者手卡。
-- ③：把墓地的这张卡除外才能发动。在自己场上把1只「小螳螂衍生物」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--プレイング・マンティス
function c31600513.initial_effect(c)
	--token 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31600513,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1,31600513)
	e1:SetCondition(c31600513.tkcon)
	e1:SetTarget(c31600513.tktg)
	e1:SetOperation(c31600513.tkop)
	c:RegisterEffect(e1)
	--return to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31600513,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetCondition(c31600513.thcon)
	e2:SetCost(c31600513.thcost)
	e2:SetTarget(c31600513.thtg)
	e2:SetOperation(c31600513.thop)
	c:RegisterEffect(e2)
	--token 2
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,31600514)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c31600513.tktg)
	e3:SetOperation(c31600513.tkop)
	c:RegisterEffect(e3)
end
function c31600513.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c31600513.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,31600514,0,TYPES_TOKEN_MONSTER,500,500,1,RACE_INSECT,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c31600513.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31600514,0,TYPES_TOKEN_MONSTER,500,500,1,RACE_INSECT,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,31600514)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c31600513.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c31600513.cfilter(c)
	return c:IsAbleToGraveAsCost() and c:GetSequence()<5
end
function c31600513.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31600513.cfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c31600513.cfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c31600513.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttacker()
	if chk==0 then return tc and tc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
end
function c31600513.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and tc:IsControler(1-tp) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
