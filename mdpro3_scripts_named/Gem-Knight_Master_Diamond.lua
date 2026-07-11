--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Gem-Knight Master Diamond  (ID: 39512984)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 9
-- ATK 2900 | DEF 2500
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 "Gem-Knight" monsters
-- Must first be Fusion Summoned.
-- Gains 100 ATK for each "Gem-" monster in your GY.
-- Once per turn: You can banish 1 Level 7 or lower "Gem-Knight" Fusion Monster from your GY; until the
-- End Phase, this card's name becomes that monster's original name, also replace this effect with that
-- monster's original effects.
--[[ __CARD_HEADER_END__ ]]

--ジェムナイトマスター・ダイヤ
function c39512984.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),3,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c39512984.splimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c39512984.atkup)
	c:RegisterEffect(e2)
	--copy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(39512984,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c39512984.cost)
	e3:SetOperation(c39512984.operation)
	c:RegisterEffect(e3)
end
function c39512984.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c39512984.atkfilter(c)
	return c:IsSetCard(0x47) and c:IsType(TYPE_MONSTER)
end
function c39512984.atkup(e,c)
	return Duel.GetMatchingGroupCount(c39512984.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
function c39512984.filter(c)
	return c:IsLevelBelow(7) and c:IsSetCard(0x1047) and c:IsType(TYPE_FUSION) and c:IsAbleToRemoveAsCost()
end
function c39512984.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39512984.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c39512984.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetOriginalCode())
end
function c39512984.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=e:GetLabel()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,1)
	end
end
