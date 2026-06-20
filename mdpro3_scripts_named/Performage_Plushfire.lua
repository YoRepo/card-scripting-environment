--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 娱乐法师 火布偶  (ID: 7563579)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1000 | DEF 1000
-- Setcode: 198
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：自己场上的表侧表示的「娱乐法师」怪兽被战斗·效果破坏的场合才能发动。这张卡特殊召唤。那之后，自己受到500伤害。
-- 【怪兽效果】
-- 这个卡名的怪兽效果1回合只能使用1次。
-- ①：场上的这张卡被战斗·效果破坏的场合才能发动。从手卡·卡组把「娱乐法师 火布偶」以外的1只「娱乐法师」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--Emヒグルミ
function c7563579.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,7563579)
	e2:SetCondition(c7563579.spcon1)
	e2:SetTarget(c7563579.sptg1)
	e2:SetOperation(c7563579.spop1)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,7563580)
	e3:SetCondition(c7563579.spcon2)
	e3:SetTarget(c7563579.sptg2)
	e3:SetOperation(c7563579.spop2)
	c:RegisterEffect(e3)
end
function c7563579.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsSetCard(0xc6)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
end
function c7563579.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c7563579.cfilter,1,nil,tp)
end
function c7563579.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,500)
end
function c7563579.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.BreakEffect()
		Duel.Damage(tp,500,REASON_EFFECT)
	end
end
function c7563579.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c7563579.spfilter(c,e,tp)
	return c:IsSetCard(0xc6) and not c:IsCode(7563579) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c7563579.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c7563579.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c7563579.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c7563579.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
