--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: The Bystial Aluber  (ID: 45005708)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1800 | DEF 0
-- Setcode: 0x188
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Fallen of Albaz" while on the field or in the GY.
-- If this card is Normal or Special Summoned: You can discard 1 card, then target 1 Dragon monster
-- your opponent controls or in their GY, and activate the appropriate effect;
-- ● Send this card to the GY, and if you do, take control of that monster on the field until the End
-- Phase.
-- ● Send this card to the GY, and if you do, Special Summon that monster from the GY to your field.
-- You can only use this effect of "The Bystial Aluber" once per turn.
--[[ __CARD_HEADER_END__ ]]

--深淵の獣アルベル
function c45005708.initial_effect(c)
	--change name
	aux.EnableChangeCode(c,68468459,LOCATION_MZONE+LOCATION_GRAVE)
	--control or special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,45005708)
	e1:SetCost(c45005708.cost)
	e1:SetTarget(c45005708.tg)
	e1:SetOperation(c45005708.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c45005708.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c45005708.filter1(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsControlerCanBeChanged()
end
function c45005708.filter2(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45005708.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if e:GetLabel()==0 then
			return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c45005708.filter1(chkc)
		else
			return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c45005708.filter2(chkc,e,tp)
		end
	end
	local c=e:GetHandler()
	local b1=Duel.IsExistingTarget(c45005708.filter1,tp,0,LOCATION_MZONE,1,nil)
	local b2=Duel.IsExistingTarget(c45005708.filter2,tp,0,LOCATION_GRAVE,1,nil,e,tp) and Duel.GetMZoneCount(tp,c)>0
	if chk==0 then return c:IsAbleToGrave() and (b1 or b2) end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(45005708,0),aux.Stringid(45005708,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(45005708,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(45005708,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_CONTROL)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectTarget(tp,c45005708.filter1,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c45005708.filter2,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
end
function c45005708.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or Duel.SendtoGrave(c,REASON_EFFECT)==0 then return end
	if c:GetLocation()~=LOCATION_GRAVE or not tc:IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then
		Duel.GetControl(tc,tp,PHASE_END,1)
	else
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
