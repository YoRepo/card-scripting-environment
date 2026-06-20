--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 猛力反击  (ID: 8316565)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 409
--
-- Effect Text:
-- 自己场上有名字带有「燃烧拳击手」的怪兽存在的场合才能发动。战斗阶段中发动的效果怪兽的效果·魔法·陷阱卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ジョルト・カウンター
function c8316565.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c8316565.condition)
	e1:SetTarget(c8316565.target)
	e1:SetOperation(c8316565.activate)
	c:RegisterEffect(e1)
end
function c8316565.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1084)
end
function c8316565.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.IsExistingMatchingCard(c8316565.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and ph>PHASE_MAIN1 and ph<PHASE_MAIN2
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c8316565.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c8316565.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
