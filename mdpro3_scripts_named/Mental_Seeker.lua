--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 精神探寻者  (ID: 36565699)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Psychic
-- Level 3
-- ATK 800 | DEF 600
--
-- Effect Text:
-- 从游戏中除外的这张卡特殊召唤成功时，从对方卡组上面把3张卡翻开，自己从那之中选择1张从游戏中除外，剩下的卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--メンタルシーカー
function c36565699.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36565699,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c36565699.condition)
	e1:SetTarget(c36565699.target)
	e1:SetOperation(c36565699.activate)
	c:RegisterEffect(e1)
end
function c36565699.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_REMOVED)
end
function c36565699.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_DECK)
end
function c36565699.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,3)
	local g=Duel.GetDecktopGroup(1-tp,3)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:FilterSelect(tp,Card.IsAbleToRemove,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
	end
end
