--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 挥精灵  (ID: 61807040)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 2
-- ATK 800 | DEF 1300
--
-- Effect Text:
-- 1回合1次，把手卡1只怪兽给对方观看才能发动。直到结束阶段时，这张卡的等级上升给人观看的怪兽的等级数值。
--[[ __CARD_HEADER_END__ ]]

--フルエルフ
function c61807040.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61807040,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c61807040.cost)
	e1:SetOperation(c61807040.operation)
	c:RegisterEffect(e1)
end
function c61807040.cfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c61807040.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61807040.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c61807040.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c61807040.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
