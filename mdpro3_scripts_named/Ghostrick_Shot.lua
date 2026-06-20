--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 鬼计曲线球  (ID: 69809989)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 141
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从自己的手卡·墓地选1只「鬼计」怪兽特殊召唤。那之后，可以选自己场上1只里侧表示的「鬼计」怪兽变成表侧攻击表示。
-- ②：把墓地的这张卡除外，以自己场上1只「鬼计」超量怪兽为对象才能发动。从自己墓地选1张「鬼计」卡在作为对象的怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・ショット
function c69809989.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69809989,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,69809989)
	e1:SetTarget(c69809989.sptg)
	e1:SetOperation(c69809989.spop)
	c:RegisterEffect(e1)
	--grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69809989,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,69809990)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c69809989.mattg)
	e2:SetOperation(c69809989.matop)
	c:RegisterEffect(e2)
end
function c69809989.spfilter(c,e,tp)
	return c:IsSetCard(0x8d) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c69809989.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c69809989.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c69809989.cfilter(c)
	return c:IsSetCard(0x8d) and c:IsFacedown() and c:IsCanChangePosition()
end
function c69809989.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c69809989.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0
		and Duel.IsExistingMatchingCard(c69809989.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(69809989,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local sg=Duel.SelectMatchingCard(tp,c69809989.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.ChangePosition(sg,POS_FACEUP_ATTACK)
	end
end
function c69809989.xyzfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x8d)
end
function c69809989.mfilter(c)
	return c:IsSetCard(0x8d) and c:IsCanOverlay()
end
function c69809989.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsPosition(LOCATION_MZONE) and c69809989.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c69809989.xyzfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c69809989.mfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c69809989.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c69809989.matop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c69809989.mfilter),tp,LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.Overlay(tc,g)
		end
	end
end
