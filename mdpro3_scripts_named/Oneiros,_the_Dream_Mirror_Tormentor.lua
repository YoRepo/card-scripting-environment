--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 梦魔镜的魇魔-涅伊洛斯  (ID: 37678339)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 10
-- ATK 3000 | DEF 3000
-- Setcode: 305
--
-- Effect Text:
-- 属性不同的「梦魔镜」怪兽×2
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要这张卡在怪兽区域存在，这张卡的属性也当作「光」使用。
-- ②：场地区域有「黯黑之梦魔镜」存在，怪兽的效果发动时才能发动。那个效果无效。
-- ③：场地区域有「圣光之梦魔镜」存在的场合，把这张卡解放才能发动。从额外卡组把1只「梦魔镜的天魔-涅伊洛斯」守备表示特殊召唤。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--夢魔鏡の魘魔－ネイロス
function c37678339.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355,35187185)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c37678339.ffilter,2,true)
	--attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37678339,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,37678339)
	e2:SetCondition(c37678339.discon)
	e2:SetTarget(c37678339.distg)
	e2:SetOperation(c37678339.disop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37678339,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,37678340)
	e3:SetCondition(c37678339.spcon)
	e3:SetCost(c37678339.spcost)
	e3:SetTarget(c37678339.sptg)
	e3:SetOperation(c37678339.spop)
	c:RegisterEffect(e3)
end
function c37678339.ffilter(c,fc,sub,mg,sg)
	return c:IsFusionSetCard(0x131) and (not sg or not sg:IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
function c37678339.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsChainDisablable(ev) and Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE)
end
function c37678339.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c37678339.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c37678339.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE)
end
function c37678339.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c37678339.spfilter(c,e,tp,mc)
	return c:IsCode(35187185) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c37678339.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37678339.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37678339.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37678339.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
