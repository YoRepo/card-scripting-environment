--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: No.39 希望皇 彼端超霍普  (ID: 21521304)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 6
-- ATK 3000 | DEF 2500
-- Setcode: 276758600
--
-- Effect Text:
-- 6星怪兽×2
-- 这个卡名在规则上也当作「希望皇 霍普」卡使用。
-- ①：这张卡超量召唤成功的场合发动。对方场上的全部怪兽的攻击力变成0。
-- ②：1回合1次，把这张卡1个超量素材取除，以自己场上1只超量怪兽和自己墓地1只「希望皇
-- 霍普」怪兽为对象才能发动。那只自己场上的超量怪兽除外，那只墓地的怪兽特殊召唤。那之后，自己回复1250基本分。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--No.39 希望皇ビヨンド・ザ・ホープ
function c21521304.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21521304,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c21521304.atkcon)
	e1:SetOperation(c21521304.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21521304,1))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c21521304.spcost)
	e2:SetTarget(c21521304.sptg)
	e2:SetOperation(c21521304.spop)
	c:RegisterEffect(e2)
end
aux.xyz_number[21521304]=39
function c21521304.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c21521304.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c21521304.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c21521304.rmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToRemove()
end
function c21521304.spfilter(c,e,tp)
	return c:IsSetCard(0x107f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21521304.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c21521304.rmfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c21521304.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,c21521304.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c21521304.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g2,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,1250)
end
function c21521304.spop(e,tp,eg,ep,ev,re,r,rp)
	local ex,g1=Duel.GetOperationInfo(0,CATEGORY_REMOVE)
	local ex,g2=Duel.GetOperationInfo(0,CATEGORY_SPECIAL_SUMMON)
	local tc1=g1:GetFirst()
	if not tc1:IsRelateToEffect(e) or Duel.Remove(tc1,POS_FACEUP,REASON_EFFECT)==0 then return end
	local tc2=g2:GetFirst()
	if not tc2:IsRelateToEffect(e) or Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	Duel.BreakEffect()
	Duel.Recover(tp,1250,REASON_EFFECT)
end
