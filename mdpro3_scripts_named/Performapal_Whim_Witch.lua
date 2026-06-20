--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 娱乐伙伴 妙想魔女  (ID: 64450427)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- Pendulum Scales: L4 / R4
-- ATK 800 | DEF 800
-- Setcode: 159
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- 「娱乐伙伴 妙想魔女」的灵摆效果1回合只能使用1次。
-- ①：从额外卡组特殊召唤的怪兽只有对方场上才存在的场合才能发动。灵摆区域的这张卡特殊召唤。
-- 【怪兽效果】
-- ①：灵摆怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--EMウィム・ウィッチ
function c64450427.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64450427,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,64450427)
	e1:SetCondition(c64450427.spcon)
	e1:SetTarget(c64450427.sptg)
	e1:SetOperation(c64450427.spop)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c64450427.dtcon)
	c:RegisterEffect(e2)
end
function c64450427.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c64450427.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c64450427.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c64450427.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c64450427.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64450427.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c64450427.dtcon(e,c)
	return c:IsType(TYPE_PENDULUM)
end
