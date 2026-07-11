--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Shiny Black "C"  (ID: 94081496)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 1
-- ATK 200 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- During either player's turn, when exactly 1 Synchro Monster is Special Summoned to your opponent's
-- side of the field: You can banish this card from your Graveyard to target that face-up Synchro
-- Monster; destroy that target.
--[[ __CARD_HEADER_END__ ]]

--黒光りするG
function c94081496.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94081496,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c94081496.target)
	e1:SetOperation(c94081496.operation)
	c:RegisterEffect(e1)
end
function c94081496.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:GetFirst()
	if chkc then return chkc==tc end
	if chk==0 then return eg:GetCount()==1 and tc:IsFaceup() and tc:IsType(TYPE_SYNCHRO) and tc:IsOnField()
		and tc:IsControler(1-tp) and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c94081496.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
