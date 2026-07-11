--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Marionette Mite  (ID: 87514539)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level: 3
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard this card to the GY, then target 1 Fiend or Zombie monster your opponent controls;
-- take control of that target until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--傀儡虫
function c87514539.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87514539,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c87514539.cost)
	e1:SetTarget(c87514539.target)
	e1:SetOperation(c87514539.operation)
	c:RegisterEffect(e1)
end
function c87514539.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c87514539.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE+RACE_FIEND) and c:IsControlerCanBeChanged()
end
function c87514539.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c87514539.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c87514539.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c87514539.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c87514539.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRace(RACE_ZOMBIE+RACE_FIEND) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
