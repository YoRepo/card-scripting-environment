--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 轩辕之相剑师  (ID: 82489470)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 363
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：怪兽的攻击宣言时才能发动。这张卡从手卡特殊召唤，那次攻击无效。自己场上有需以「阿不思的落胤」为融合素材的融合怪兽存在的场合，可以再把那只攻击宣言的怪兽破坏。
-- ②：怪兽被表侧表示除外的场合，把场上·墓地的这张卡除外才能发动。从自己的手卡·墓地把攻击力和守备力的数值相同的1只魔法师族·光属性怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--軒轅の相剣師
function c82489470.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c82489470.atktg)
	e1:SetOperation(c82489470.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,82489470)
	e2:SetCondition(c82489470.spcon)
	e2:SetCost(c82489470.spcost)
	e2:SetTarget(c82489470.sptg)
	e2:SetOperation(c82489470.spop)
	c:RegisterEffect(e2)
end
function c82489470.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c82489470.atkfilter(c)
	return c:IsType(TYPE_FUSION) and aux.IsMaterialListCode(c,68468459) and c:IsFaceup()
end
function c82489470.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) and Duel.NegateAttack()
		and Duel.IsExistingMatchingCard(c82489470.atkfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(82489470,0)) then
		local tc=Duel.GetAttacker()
		Duel.HintSelection(Group.FromCards(tc))
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c82489470.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c82489470.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c82489470.rmfilter,1,nil)
end
function c82489470.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c82489470.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_SPELLCASTER) and aux.AtkEqualsDef(c)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c82489470.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c82489470.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,c,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c82489470.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c82489470.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
