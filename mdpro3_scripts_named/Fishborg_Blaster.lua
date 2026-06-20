--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 电子鱼人-枪手  (ID: 93369354)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Fish
-- Level 1
-- ATK 100 | DEF 200
-- Setcode: 150
--
-- Effect Text:
-- 自己场上有3星以下的水属性怪兽表侧表示存在的场合，丢弃1张手卡才能发动。墓地存在的这张卡在自己场上特殊召唤。把这张卡作为同调素材的场合，其他的同调素材怪兽必须全部是水属性怪兽。
--[[ __CARD_HEADER_END__ ]]

--フィッシュボーグ－ガンナー
function c93369354.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93369354,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c93369354.spcon)
	e1:SetCost(c93369354.spcost)
	e1:SetTarget(c93369354.sptg)
	e1:SetOperation(c93369354.spop)
	c:RegisterEffect(e1)
	--synchro custom
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetTarget(c93369354.synlimit)
	c:RegisterEffect(e2)
end
function c93369354.filter(c)
	return c:IsLevelBelow(3) and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c93369354.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c93369354.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c93369354.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c93369354.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c93369354.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c93369354.synlimit(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
