--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 黑幻想之魔术师  (ID: 35191415)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 2100 | DEF 2500
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己在对方回合把魔法·陷阱卡的效果发动的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡只要在怪兽区域存在，卡名当作「黑魔术师」使用。
-- ③：只在这张卡在场上表侧表示存在才有1次，自己把魔法·陷阱卡的效果发动的场合以自己墓地1只「黑魔术师」为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マジシャン・オブ・ブラック・イリュージョン
function c35191415.initial_effect(c)
	--change name
	aux.EnableChangeCode(c,46986414)
	--spsummon (self)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35191415,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,35191415)
	e2:SetCondition(c35191415.condition1)
	e2:SetTarget(c35191415.target1)
	e2:SetOperation(c35191415.operation1)
	c:RegisterEffect(e2)
	--spsummon (DM)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(35191415,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,35191416)
	e4:SetCondition(c35191415.condition2)
	e4:SetTarget(c35191415.target2)
	e4:SetOperation(c35191415.operation2)
	c:RegisterEffect(e4)
end
function c35191415.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and rp==tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c35191415.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c35191415.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c35191415.condition2(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c35191415.filter(c,e,tp)
	return c:IsCode(46986414) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c35191415.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c35191415.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c35191415.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c35191415.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c35191415.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
