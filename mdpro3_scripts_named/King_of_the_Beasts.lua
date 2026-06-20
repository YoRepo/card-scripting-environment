--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 毛兽之王  (ID: 67757079)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 7
-- ATK 2500 | DEF 800
--
-- Effect Text:
-- 可以把1只自己场上表侧表示存在的「毛扎」解放发动。这张卡从手卡或者墓地特殊召唤。「毛兽之王」在场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--キング・オブ・ビースト
function c67757079.initial_effect(c)
	c:SetUniqueOnField(1,1,67757079)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67757079,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCost(c67757079.spcost)
	e1:SetTarget(c67757079.sptg)
	e1:SetOperation(c67757079.spop)
	c:RegisterEffect(e1)
end
function c67757079.cfilter(c,ft,tp)
	return c:IsFaceup() and c:IsCode(94878265)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5))
end
function c67757079.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c67757079.cfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c67757079.cfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c67757079.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c67757079.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
