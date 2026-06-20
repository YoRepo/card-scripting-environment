--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 链犬  (ID: 96930127)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1100
--
-- Effect Text:
-- 自己场上是兽族怪兽表侧表示2只存在的场合，可以把这张卡从墓地特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合，从游戏中除外。把这张卡作为同调素材的场合，不是兽族怪兽的同调召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--チェーンドッグ
function c96930127.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96930127,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c96930127.condition)
	e1:SetTarget(c96930127.target)
	e1:SetOperation(c96930127.operation)
	c:RegisterEffect(e1)
	--syn limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c96930127.synlimit)
	c:RegisterEffect(e2)
end
function c96930127.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c96930127.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c96930127.cfilter,tp,LOCATION_MZONE,0,nil)==2
end
function c96930127.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c96930127.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
function c96930127.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_BEAST)
end
