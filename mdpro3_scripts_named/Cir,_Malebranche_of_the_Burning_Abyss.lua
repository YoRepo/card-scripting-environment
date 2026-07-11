--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Cir, Malebranche of the Burning Abyss  (ID: 57143342)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1600 | DEF 1200
-- Setcode: 0xb1
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a monster that is not a "Burning Abyss" monster, destroy this card.
-- You can only use 1 of these effects of "Cir, Malebranche of the Burning Abyss" per turn, and only
-- once that turn.
-- ● If you control no Spells/Traps: You can Special Summon this card from your hand.
-- ● If this card is sent to the GY: You can target 1 "Burning Abyss" monster in your GY, except "Cir,
-- Malebranche of the Burning Abyss"; Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--彼岸の悪鬼 ガトルホッグ
function c57143342.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c57143342.sdcon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57143342,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,57143342)
	e2:SetCondition(c57143342.sscon)
	e2:SetTarget(c57143342.sstg)
	e2:SetOperation(c57143342.ssop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57143342,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,57143342)
	e3:SetTarget(c57143342.sptg)
	e3:SetOperation(c57143342.spop)
	c:RegisterEffect(e3)
end
function c57143342.sdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xb1)
end
function c57143342.sdcon(e)
	return Duel.IsExistingMatchingCard(c57143342.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c57143342.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c57143342.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c57143342.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c57143342.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c57143342.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c57143342.spfilter(c,e,tp)
	return c:IsSetCard(0xb1) and not c:IsCode(57143342) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c57143342.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c57143342.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c57143342.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c57143342.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c57143342.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
