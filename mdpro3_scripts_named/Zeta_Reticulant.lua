--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Zeta Reticulant  (ID: 64382839)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level: 7
-- ATK 2400 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 "Eva Token" to Special Summon this card from your hand.
-- While this card is in your Graveyard, each time a monster(s) your opponent controls is removed from
-- play, Special Summon 1 "Eva Token" (Fiend-Type/DARK/Level 2/ATK 500/DEF 500).
--[[ __CARD_HEADER_END__ ]]

--ゼータ・レティキュラント
function c64382839.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64382839,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c64382839.spcon)
	e1:SetTarget(c64382839.sptg)
	e1:SetOperation(c64382839.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c64382839.hspcon)
	e2:SetTarget(c64382839.hsptg)
	e2:SetOperation(c64382839.hspop)
	c:RegisterEffect(e2)
end
function c64382839.cfilter(c,tp)
	return c:IsPreviousControler(1-tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TOKEN)
end
function c64382839.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c64382839.cfilter,1,nil,tp)
end
function c64382839.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c64382839.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,64382840,0,TYPES_TOKEN_MONSTER,500,500,2,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,64382840)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
function c64382839.spfilter(c,tp)
	return c:IsCode(64382840)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c64382839.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c64382839.spfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c64382839.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c64382839.spfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c64382839.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
