--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 真红眼黑重钢龙  (ID: 80870883)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 3400 | DEF 2400
-- Setcode: 59
--
-- Effect Text:
-- 这张卡不能通常召唤，用把5星以上的龙族怪兽解放发动的「金属化·强化反射装甲」的效果可以特殊召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：把手卡的这张卡给对方观看才能发动。从卡组把1张「金属化」陷阱卡在自己场上盖放，这张卡回到卡组。
-- ②：对方把效果发动时才能发动。那个发动无效。那之后，可以给与对方为对方场上1只攻击表示怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--レッドアイズ・ブラックフルメタルドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,89812483)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.setcost)
	e1:SetTarget(s.settg)
	e1:SetOperation(s.setop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.negcon)
	e2:SetTarget(s.negtg)
	e2:SetOperation(s.negop)
	c:RegisterEffect(e2)
end
function s.mfilter(ft,lv,race,att)
	return ft==1 and lv>=5 and bit.band(race,RACE_DRAGON)==RACE_DRAGON
end
s.Metallization_material=s.mfilter
function s.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.setfilter(c)
	return c:IsSetCard(0x1ba) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK,0,1,nil)
		and c:IsAbleToDeck() end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,s.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 and c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp and Duel.IsChainNegatable(ev)
end
function s.damfilter(c)
	return c:GetBaseAttack()>0 and c:IsPosition(POS_FACEUP_ATTACK)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and Duel.IsExistingMatchingCard(s.damfilter,tp,0,LOCATION_MZONE,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,s.damfilter,tp,0,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		Duel.HintSelection(g)
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
