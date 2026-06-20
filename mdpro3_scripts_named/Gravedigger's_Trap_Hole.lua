--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 墓穴洞  (ID: 31548215)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 137
--
-- Effect Text:
-- ①：手卡·墓地的怪兽或者除外中的怪兽的效果由对方发动时才能发动。那个效果无效，给与对方2000伤害。
--[[ __CARD_HEADER_END__ ]]

--墓穴ホール
function c31548215.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c31548215.condition)
	e1:SetTarget(c31548215.target)
	e1:SetOperation(c31548215.activate)
	c:RegisterEffect(e1)
end
function c31548215.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep==1-tp and Duel.IsChainDisablable(ev) and re:IsActiveType(TYPE_MONSTER) and (LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)&loc~=0
end
function c31548215.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
end
function c31548215.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		Duel.Damage(1-tp,2000,REASON_EFFECT)
	end
end
