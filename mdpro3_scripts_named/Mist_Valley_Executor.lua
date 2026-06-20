--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 霞之谷的执行者  (ID: 41978142)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Thunder
-- Level 5
-- ATK 2100 | DEF 1600
-- Setcode: 55
--
-- Effect Text:
-- 这张卡召唤成功时，场上表侧表示存在的魔法·陷阱卡全部回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--霞の谷の執行者
function c41978142.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41978142,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c41978142.thtg)
	e1:SetOperation(c41978142.thop)
	c:RegisterEffect(e1)
end
function c41978142.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c41978142.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c41978142.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c41978142.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41978142.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
