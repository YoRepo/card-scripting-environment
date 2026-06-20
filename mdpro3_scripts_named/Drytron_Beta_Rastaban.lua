--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 龙辉巧-天棓三β  (ID: 33543890)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 2000 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这张卡不能通常召唤，用「龙辉巧」卡的效果才能特殊召唤。这个卡名的效果1回合只能使用1次。
-- ①：从自己的手卡·场上把1只这张卡以外的「龙辉巧」怪兽或者仪式怪兽解放才能发动。这张卡从手卡·墓地守备表示特殊召唤。那之后，可以选除外的1只自己的「龙辉巧」怪兽回到墓地。这个效果发动的回合，自己若非不
-- 能通常召唤的怪兽则不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ラスβ
function c33543890.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c33543890.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c33543890.extraop)
	e2:SetDescription(aux.Stringid(33543890,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e2:SetCountLimit(1,33543890)
end
function c33543890.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c33543890.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x154) and c:IsType(TYPE_MONSTER)
end
function c33543890.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c33543890.tgfilter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(33543890,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
end
