--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 战华之义-关云  (ID: 76416959)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast-Warrior
-- Level 7
-- ATK 2500 | DEF 1800
-- Setcode: 311
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：只有对方场上才有怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的其他的「战华」怪兽不会成为对方的效果的对象。
-- ③：对方场上的怪兽数量比自己场上的怪兽多的场合，以对方场上1只怪兽为对象才能发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--戦華の義－関雲
function c76416959.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76416959,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c76416959.spcon)
	e1:SetTarget(c76416959.sptg)
	e1:SetOperation(c76416959.spop)
	c:RegisterEffect(e1)
	--can not be effect target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c76416959.etlimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(76416959,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,76416959)
	e3:SetCondition(c76416959.descon)
	e3:SetTarget(c76416959.destg)
	e3:SetOperation(c76416959.desop)
	c:RegisterEffect(e3)
end
function c76416959.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)>0
end
function c76416959.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c76416959.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c76416959.etlimit(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsSetCard(0x137)
end
function c76416959.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
end
function c76416959.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c76416959.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
