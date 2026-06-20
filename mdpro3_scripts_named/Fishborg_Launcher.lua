--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电子鱼人-火箭炮手  (ID: 66853752)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Fish
-- Level 1
-- ATK 200 | DEF 100
-- Setcode: 150
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次，把这张卡作为同调素材的场合，不是水属性怪兽的同调召唤不能使用。
-- ①：这张卡在墓地存在，「电子鱼人-火箭炮手」以外的自己墓地的怪兽只有水属性怪兽的场合才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--フィッシュボーグ－ランチャー
function c66853752.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66853752,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,66853752)
	e1:SetCondition(c66853752.condition)
	e1:SetTarget(c66853752.target)
	e1:SetOperation(c66853752.operation)
	c:RegisterEffect(e1)
	--synchro limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c66853752.synlimit)
	c:RegisterEffect(e2)
end
function c66853752.cfilter(c)
	return not c:IsCode(66853752) and c:IsType(TYPE_MONSTER)
end
function c66853752.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c66853752.cfilter,tp,LOCATION_GRAVE,0,nil)
	return g:GetCount()>0 and g:FilterCount(Card.IsAttribute,nil,ATTRIBUTE_WATER)==g:GetCount()
end
function c66853752.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66853752.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.GetMatchingGroup(c66853752.cfilter,tp,LOCATION_GRAVE,0,nil)
		if g:GetCount()>0 and g:FilterCount(Card.IsAttribute,nil,ATTRIBUTE_WATER)==g:GetCount()
			and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
			e1:SetValue(LOCATION_REMOVED)
			c:RegisterEffect(e1,true)
		end
	end
end
function c66853752.synlimit(e,c)
	if not c then return false end
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
