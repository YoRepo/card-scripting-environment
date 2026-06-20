--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 时间潜行者启动  (ID: 10877309)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 294
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从手卡把1只「时间潜行者」怪兽特殊召唤。
-- ②：自己主要阶段把墓地的这张卡除外，以自己场上1只「时间潜行者」超量怪兽为对象才能发动。从自己墓地选「时间潜行者」卡3种类（怪兽·魔法·陷阱）各1张在作为对象的怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--クロノダイバー・スタートアップ
function c10877309.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10877309)
	e1:SetTarget(c10877309.target)
	e1:SetOperation(c10877309.activate)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10877309,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,10877309)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c10877309.mattg)
	e2:SetOperation(c10877309.matop)
	c:RegisterEffect(e2)
end
function c10877309.filter(c,e,tp)
	return c:IsSetCard(0x126) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10877309.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10877309.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c10877309.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10877309.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10877309.xyzfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x126)
end
function c10877309.matfilter(c)
	return c:IsSetCard(0x126) and c:IsCanOverlay()
end
function c10877309.ccfilter(c)
	return bit.band(c:GetType(),0x7)
end
function c10877309.fselect(g)
	return g:GetClassCount(c10877309.ccfilter)==g:GetCount()
end
function c10877309.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(c10877309.matfilter,tp,LOCATION_GRAVE,0,e:GetHandler())
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c10877309.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10877309.xyzfilter,tp,LOCATION_MZONE,0,1,nil)
		and g:CheckSubGroup(c10877309.fselect,3,3) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c10877309.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10877309.matop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c10877309.matfilter),tp,LOCATION_GRAVE,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local sg=g:SelectSubGroup(tp,c10877309.fselect,false,3,3)
		if sg and sg:GetCount()==3 then
			Duel.Overlay(tc,sg)
		end
	end
end
