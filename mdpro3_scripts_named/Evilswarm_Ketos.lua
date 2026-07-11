--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Evilswarm Ketos  (ID: 40921545)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Aqua
-- Level: 4
-- ATK 1750 | DEF 1050
-- Setcode: 0xa
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute this card, then target 1 Spell/Trap Card your opponent controls; destroy that
-- target.
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・カイトス
function c40921545.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40921545,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c40921545.cost)
	e1:SetTarget(c40921545.target)
	e1:SetOperation(c40921545.operation)
	c:RegisterEffect(e1)
end
function c40921545.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c40921545.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c40921545.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) end
	if chk==0 then return Duel.IsExistingTarget(c40921545.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c40921545.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c40921545.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
