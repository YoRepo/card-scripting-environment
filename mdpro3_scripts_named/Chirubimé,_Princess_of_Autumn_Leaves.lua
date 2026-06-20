--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 红姬 知流姬  (ID: 87294988)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 8
-- ATK 1800 | DEF 2800
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方不能选择其他的植物族怪兽作为攻击对象。此外，这张卡被对方送去墓地的场合，可以从卡组把「红姬 知流姬」以外的1只植物族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--紅姫チルビメ
function c87294988.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c87294988.bttg)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87294988,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c87294988.spcon)
	e2:SetTarget(c87294988.sptg)
	e2:SetOperation(c87294988.spop)
	c:RegisterEffect(e2)
end
function c87294988.bttg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c87294988.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c87294988.filter(c,e,tp)
	return c:IsRace(RACE_PLANT) and not c:IsCode(87294988) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87294988.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c87294988.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c87294988.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c87294988.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
