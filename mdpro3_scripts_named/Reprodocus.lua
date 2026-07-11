--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Reprodocus  (ID: 34989413)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Dinosaur
-- Link Rating: 2
-- Link Arrows: Top, Bottom
-- ATK 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters
-- You can activate 1 of these effects.
-- ● Declare 1 Monster Type; all face-up monsters this card points to become that Type until the end of
-- this turn.
-- ● Declare 1 Attribute; all face-up monsters this card points to become that Attribute until the end
-- of this turn.
-- You can only use this effect of "Reprodocus" once per turn.
--[[ __CARD_HEADER_END__ ]]

--リプロドクス
function c34989413.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34989413,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,34989413)
	e1:SetTarget(c34989413.ractg)
	e1:SetOperation(c34989413.racop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(34989413,1))
	e2:SetTarget(c34989413.atttg)
	e2:SetOperation(c34989413.attop)
	c:RegisterEffect(e2)
end
function c34989413.filter(c,g)
	return c:IsFaceup() and g:IsContains(c)
end
function c34989413.ractg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.IsExistingMatchingCard(c34989413.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,lg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rac=Duel.AnnounceRace(tp,1,RACE_ALL)
	e:SetLabel(rac)
end
function c34989413.racop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local lg=c:GetLinkedGroup()
	local g=Duel.GetMatchingGroup(c34989413.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lg)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c34989413.atttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.IsExistingMatchingCard(c34989413.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,lg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local att=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:SetLabel(att)
end
function c34989413.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local lg=c:GetLinkedGroup()
	local g=Duel.GetMatchingGroup(c34989413.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lg)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
