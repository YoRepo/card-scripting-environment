--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 武神-蛭子  (ID: 70026064)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- Pendulum Scales: L3 / R3
-- ATK 1000 | DEF 2000
-- Setcode: 136
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：把自己的灵摆区域的这张卡除外，以自己场上1只「武神」超量怪兽为对象才能发动。和那只自己怪兽卡名不同的1只「武神」超量怪兽在作为对象的怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
-- 【怪兽描述】
-- 遥远的太古过去赌上主神的宝座跟「武神-日孁」战斗，在死斗之后被封印起来的恶神。为使自己的封印解开而操纵了「日孁」，产生出不祥的「天照」给世界带来了黑暗，但他的野心在「倭」等年轻武神的活跃之下最终破灭了
-- 。
--[[ __CARD_HEADER_END__ ]]

--武神－ヒルコ
function c70026064.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCost(c70026064.spcost)
	e2:SetTarget(c70026064.sptg)
	e2:SetOperation(c70026064.spop)
	c:RegisterEffect(e2)
end
function c70026064.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c70026064.filter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x88)
		and Duel.IsExistingMatchingCard(c70026064.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetCode())
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c70026064.filter2(c,e,tp,mc,code)
	return c:IsType(TYPE_XYZ) and c:IsSetCard(0x88) and not c:IsCode(code) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c70026064.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c70026064.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c70026064.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c70026064.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c70026064.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c70026064.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetCode())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
