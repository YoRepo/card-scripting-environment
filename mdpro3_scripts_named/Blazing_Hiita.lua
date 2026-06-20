--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 盛燃之希塔  (ID: 92518817)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 4
-- ATK 800 | DEF 1500
--
-- Effect Text:
-- 可以把自己场上除这张卡以外的1只炎属性怪兽做祭品，从手卡特殊召唤1只炎属性怪兽。这个效果1回合只能使用1次。这个效果特殊召唤的怪兽，在「盛燃之希塔」从自己场上离开的场合破坏。
--[[ __CARD_HEADER_END__ ]]

--燃え盛るヒータ
function c92518817.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c92518817.spcost)
	e1:SetTarget(c92518817.sptg)
	e1:SetOperation(c92518817.spop)
	c:RegisterEffect(e1)
end
function c92518817.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,e:GetHandler(),ATTRIBUTE_FIRE) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,e:GetHandler(),ATTRIBUTE_FIRE)
	Duel.Release(g,REASON_COST)
end
function c92518817.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92518817.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c92518817.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c92518817.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c92518817.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetOperation(c92518817.desop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		g:GetFirst():RegisterEffect(e1)
	end
end
function c92518817.desop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(Card.IsCode,1,nil,92518817) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
