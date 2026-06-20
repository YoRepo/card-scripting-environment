--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 闪电三角兽  (ID: 49389523)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Beast
-- Level 8
-- ATK 2800 | DEF 2000
--
-- Effect Text:
-- 调整＋调整以外的兽族怪兽1只以上
-- 这张卡被对方破坏的场合，可以选择自己墓地存在的1只「雷电独角兽」或者「流电双角兽」在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ライトニング・トライコーン
function c49389523.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_BEAST),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49389523,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c49389523.spcon)
	e1:SetTarget(c49389523.sptg)
	e1:SetOperation(c49389523.spop)
	c:RegisterEffect(e1)
end
function c49389523.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c49389523.filter(c,e,tp)
	return c:IsCode(77506119,13995824) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49389523.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c49389523.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c49389523.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c49389523.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c49389523.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
