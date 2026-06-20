--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 廷达魔三角之使徒  (ID: 67744384)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 1600
-- Setcode: 267
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡反转的场合才能发动。选自己场上最多3只里侧表示怪兽变成表侧守备表示。这个效果变成表侧守备表示的怪兽全部是「廷达魔三角」怪兽的场合，可以把最多有那些怪兽数量的「廷达魔三角」卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ティンダングル・アポストル
function c67744384.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67744384,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,67744384)
	e1:SetTarget(c67744384.target)
	e1:SetOperation(c67744384.operation)
	c:RegisterEffect(e1)
end
function c67744384.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function c67744384.thfilter(c)
	return c:IsSetCard(0x10b) and c:IsAbleToHand()
end
function c67744384.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,3,nil)
	if g:GetCount()>0 then
		local ct=Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		local og=Duel.GetOperatedGroup()
		if og:IsExists(Card.IsSetCard,ct,nil,0x10b) then
			local sg=Duel.GetMatchingGroup(c67744384.thfilter,tp,LOCATION_DECK,0,nil)
			if sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(67744384,1)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local tg=sg:Select(tp,1,ct,nil)
				Duel.SendtoHand(tg,tp,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,tg)
			end
		end
	end
end
