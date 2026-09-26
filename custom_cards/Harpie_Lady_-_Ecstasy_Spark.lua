--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-09-26T00:00:00
-- Card: Harpie Lady - Ecstasy Spark  (ID: 99810030)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level 5
-- ATK 1300 | DEF 1400
-- Setcode: 0x64 (Harpie)
--
-- Materials: 1 Winged Beast monster + 1 Warrior monster
--
-- Effect Text:
-- Must first either be Fusion Summoned, or Special Summoned from your Extra Deck by banishing 1
-- Spell/Trap that mentions a "Harpie" card from your GY. You can only Special Summon "Harpie Lady -
-- Ecstasy Spark" once per turn this way.
-- ① This card's name becomes "Harpie Lady" while on the field or GY.
-- ② While you control 3 or more "Harpie Lady", their ATK becomes 2700.
--[[ __CARD_HEADER_END__ ]]

--Harpie Lady - Ecstasy Spark
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddSetNameMonsterList(c,0x64)
	c:EnableReviveLimit()
	--fusion material: 1 Winged Beast monster + 1 Warrior monster
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),true)
	--must first be Fusion Summoned, or Special Summoned by the procedure below (only gated in the Extra Deck)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(s.splimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): banish 1 Spell/Trap that mentions a "Harpie" card from your GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) name becomes "Harpie Lady" while on the field or in the GY
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--(2) while you control 3+ "Harpie Lady": their ATK becomes 2700
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(s.hlcon)
	e2:SetTarget(s.atktg)
	e2:SetValue(2700)
	c:RegisterEffect(e2)
end
--Summoning Condition (from the Extra Deck: Fusion Summon, or the SS proc below, which the engine does not check against this)
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
--SS proc (banish 1 Spell/Trap that mentions a "Harpie" card from your GY)
--same "mentions a "Harpie" card" test as Harpie Lady - Hunting Ground: no real S/T registers
--AddSetNameMonsterList(c,0x64); those naming "Harpie Lady"/"Harpie Lady Sisters" register 12206212, and
--"Gryphon Wing" (55608151), "Harpie's Feather Storm" (87639778), "Hysteric Party" (77778835) and
--"Hysteric Sign" (19337371) register nothing, so they are listed by code
function s.spcfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemoveAsCost()
		and (aux.IsSetNameMonsterListed(c,0x64) or aux.IsCodeListed(c,76812113) or aux.IsCodeListed(c,12206212)
			or aux.IsCodeListed(c,18144506) or c:IsCode(55608151,87639778,77778835,19337371))
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_SPSUMMON)
end
--(2)
--"Harpie Lady" you control: face-up (a face-down card keeps its printed code), incl. this card
function s.hlfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function s.hlcon(e)
	return Duel.IsExistingMatchingCard(s.hlfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,3,nil)
end
--continuous "becomes" is EFFECT_SET_ATTACK (cf. Mokey Mokey Smackdown): continuous boosts still apply on top
function s.atktg(e,c)
	return s.hlfilter(c)
end
