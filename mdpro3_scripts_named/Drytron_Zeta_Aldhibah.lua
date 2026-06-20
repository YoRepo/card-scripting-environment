--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 龙辉巧-上弼ζ  (ID: 96026108)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 2000 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这张卡不能通常召唤，用「龙辉巧」卡的效果才能特殊召唤。这个卡名的效果1回合只能使用1次。
-- ①：把这张卡以外的自己的手卡·场上1只「龙辉巧」怪兽或仪式怪兽解放才能发动（这个效果发动的回合，自己若非不能通常召唤的怪兽则不能特殊召唤）。这张卡从手卡·墓地守备表示特殊召唤。那之后，可以从卡组把1张
-- 仪式魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－アルζ
function c96026108.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c96026108.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c96026108.extraop)
	e2:SetDescription(aux.Stringid(96026108,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e2:SetCountLimit(1,96026108)
end
function c96026108.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c96026108.thfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c96026108.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c96026108.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(96026108,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
