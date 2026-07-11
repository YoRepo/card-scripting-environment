--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: SPYRAL Tough  (ID: 20584712)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 4
-- ATK 1900 | DEF 1500
-- Setcode: 0xee
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "SPYRAL Super Agent" while it is on the field or in the GY.
-- Once per turn: You can declare 1 type of card (Monster, Spell, or Trap) and target 1 card your
-- opponent controls; reveal the top card of your opponent's Deck, and if you do, destroy the targeted
-- card if the revealed card is the declared type.
--[[ __CARD_HEADER_END__ ]]

--SPYRAL－タフネス
function c20584712.initial_effect(c)
	--change name
	aux.EnableChangeCode(c,41091257,LOCATION_MZONE+LOCATION_GRAVE)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20584712,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c20584712.destg)
	e2:SetOperation(c20584712.desop)
	c:RegisterEffect(e2)
end
function c20584712.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function c20584712.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)==0 then return end
	local dc=Duel.GetFirstTarget()
	if not dc:IsRelateToEffect(e) then return end
	Duel.ConfirmDecktop(1-tp,1)
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	local opt=e:GetLabel()
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		Duel.Destroy(dc,REASON_EFFECT)
	end
end
