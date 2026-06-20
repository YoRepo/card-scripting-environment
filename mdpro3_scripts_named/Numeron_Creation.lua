--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 源数创造  (ID: 46382143)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 276496714
--
-- Effect Text:
-- 这个卡名在规则上也当作「银河眼」卡使用。这个卡名的效果1回合只能适用1次。
-- ①：原本攻击力是3000以上的龙族·光属性怪兽在场上有3只以上存在的场合才能发动。从额外卡组把1只龙族「No.」超量怪兽特殊召唤。那之后，把场上的这张卡在那只怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--ヌメロン・クリエイション
function c46382143.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c46382143.condition)
	e1:SetTarget(c46382143.target)
	e1:SetOperation(c46382143.activate)
	c:RegisterEffect(e1)
end
function c46382143.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON) and c:GetBaseAttack()>=3000 and c:IsFaceup()
end
function c46382143.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c46382143.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>=3
end
function c46382143.spfilter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c46382143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,46382143)==0
		and Duel.IsExistingMatchingCard(c46382143.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c46382143.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,46382143)~=0 then return end
	Duel.RegisterFlagEffect(tp,46382143,RESET_PHASE+PHASE_END,0,1)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c46382143.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 and tc:IsLocation(LOCATION_MZONE)
		and c:IsLocation(LOCATION_ONFIELD) and c:IsRelateToEffect(e) and c:IsCanOverlay() then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
