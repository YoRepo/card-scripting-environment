--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 袭击队飞翼  (ID: 52159691)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 0 | DEF 2000
-- Setcode: 12194011
--
-- Effect Text:
-- 这个卡名在规则上也当作「幻影骑士团」卡、「急袭猛禽」卡使用。这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡在手卡·墓地存在的场合，把自己场上的暗属性超量怪兽1个超量素材取除才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
-- ②：持有这张卡作为素材中的原本属性是暗属性的超量怪兽得到以下效果。
-- ●这张卡不会成为对方的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--レイダーズ・ウィング
function c52159691.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52159691,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,52159691)
	e1:SetCost(c52159691.spcost)
	e1:SetTarget(c52159691.sptg)
	e1:SetOperation(c52159691.spop)
	c:RegisterEffect(e1)
	--get effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_XMATERIAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetCondition(c52159691.xmatcon)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c52159691.cfilter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_XYZ)
		and c:CheckRemoveOverlayCard(tp,1,REASON_COST)
end
function c52159691.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c52159691.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEATTACHFROM)
	local c=Duel.SelectMatchingCard(tp,c52159691.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c52159691.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c52159691.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		c:RegisterEffect(e1,true)
	end
end
function c52159691.xmatcon(e)
	return e:GetHandler():GetOriginalAttribute()==ATTRIBUTE_DARK
end
