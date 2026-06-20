--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 龙辉巧-天厨一δ  (ID: 22420202)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 2000 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这张卡不能通常召唤，用「龙辉巧」卡的效果才能特殊召唤。这个卡名的效果1回合只能使用1次。
-- ①：把这张卡以外的自己的手卡·场上1只「龙辉巧」怪兽或仪式怪兽解放才能发动（这个效果发动的回合，自己若非不能通常召唤的怪兽则不能特殊召唤）。这张卡从手卡·墓地守备表示特殊召唤。那之后，可以把手卡1只仪
-- 式怪兽或1张仪式魔法卡给对方观看让自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ルタδ
function c22420202.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c22420202.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c22420202.extraop)
	e2:SetDescription(aux.Stringid(22420202,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e2:SetCountLimit(1,22420202)
end
function c22420202.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c22420202.drfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER+TYPE_SPELL) and not c:IsPublic()
end
function c22420202.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c22420202.drfilter,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(22420202,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
