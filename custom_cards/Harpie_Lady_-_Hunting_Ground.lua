--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-09-25T00:00:00
-- Card: Harpie Lady - Hunting Ground  (ID: 99810010)
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
-- Must first be either Fusion Summoned, or Special Summoned (from your Extra Deck) by revealing 1 Set
-- Spell/Trap you control that mentions a "Harpie" card. You can only Special Summon "Harpie Lady -
-- Hunting Ground" once per turn this way.
-- ① When this card is Special Summoned: Target 1 Spell/Trap on the field; destroy it.
-- ② This card's name becomes "Harpie Lady" while on the field or in the GY.
--[[ __CARD_HEADER_END__ ]]

--Harpie Lady - Hunting Ground
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
	--SS proc (from Extra Deck): reveal 1 Set S/T you control that mentions a "Harpie" card
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
	--(1) when this card is SS'd: target 1 S/T on the field; destroy it (mandatory)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
	--(2) name becomes "Harpie Lady" while on the field or in the GY
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
end
--Summoning Condition (from the Extra Deck: Fusion Summon, or the SS proc below, which the engine does not check against this)
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
--SS proc (reveal 1 Set Spell/Trap you control that mentions a "Harpie" card)
--the archetype, or any "Harpie" card by name, counts (cf. Toon World the Perfect World's "Toon" card filter).
--No real S/T registers AddSetNameMonsterList(c,0x64); those naming "Harpie Lady"/"Harpie Lady Sisters" register
--12206212. "Gryphon Wing" (55608151), "Harpie's Feather Storm" (87639778), "Hysteric Party" (77778835) and
--"Hysteric Sign" (19337371) register nothing, so they are listed by code
function s.spcfilter(c)
	return c:IsFacedown() and c:IsType(TYPE_SPELL+TYPE_TRAP)
		and (aux.IsSetNameMonsterListed(c,0x64) or aux.IsCodeListed(c,76812113) or aux.IsCodeListed(c,12206212)
			or aux.IsCodeListed(c,18144506) or c:IsCode(55608151,87639778,77778835,19337371))
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_SZONE,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_SZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	--reveal only: the card stays Set
	local tc=e:GetLabelObject()
	Duel.ConfirmCards(1-tp,tc)
end
--(1)
function s.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and s.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,s.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
