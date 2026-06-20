--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 光与暗的仪式  (ID: 33599853)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放或者作为解放的代替而把自己墓地的怪兽除外，从手卡把「黑色混沌之魔术师 黑混沌」或「光与暗之战士 混沌战士」仪式召唤。
-- ②：这张卡在墓地存在的场合才能发动。把有「光与暗的仪式」的卡名记述的1张卡和这张卡从自己墓地加入手卡。
--[[ __CARD_HEADER_END__ ]]

--光と闇の儀式
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,33599853,44001993,70405001)
	local e1=aux.AddRitualProcGreater2(c,s.rfilter,nil,s.grfilter)
	e1:SetDescription(aux.Stringid(id,0))
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.rfilter(c)
	return c:IsCode(44001993,70405001)
end
function s.grfilter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function s.thfilter(c)
	return aux.IsCodeListed(c,33599853) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_GRAVE,0,1,c) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and aux.NecroValleyFilter()(c) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE,0,1,1,c)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			g:AddCard(c)
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
