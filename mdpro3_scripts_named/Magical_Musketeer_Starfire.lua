--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔弹射手 斯塔尔  (ID: 31629407)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 4
-- ATK 1300 | DEF 1700
-- Setcode: 264
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己·对方回合自己可以把「魔弹」魔法·陷阱卡从手卡发动。
-- ②：和这张卡相同纵列有魔法·陷阱卡发动的场合才能发动。除「魔弹射手 斯塔尔」外的1只4星以下的「魔弹」怪兽从卡组守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔弾の射手 スター
function c31629407.initial_effect(c)
	--activate from hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31629407,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x108))
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetValue(32841045)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(31629407,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,31629407)
	e3:SetCondition(c31629407.spcon)
	e3:SetTarget(c31629407.sptg)
	e3:SetOperation(c31629407.spop)
	c:RegisterEffect(e3)
end
function c31629407.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():GetColumnGroup():IsContains(re:GetHandler())
end
function c31629407.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x108) and not c:IsCode(31629407) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c31629407.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c31629407.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c31629407.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tg=Duel.SelectMatchingCard(tp,c31629407.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tg then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
