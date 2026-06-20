--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 熔岩炮击手  (ID: 11834972)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 800
-- Setcode: 57
--
-- Effect Text:
-- 这张卡召唤成功时，自己墓地有「熔岩炮击手」以外的名字带有「熔岩」的怪兽存在的场合，从自己卡组上面把最多5张卡送去墓地才能发动。这张卡的攻击力上升因为这个效果发动而送去墓地的名字带有「熔岩」的怪兽数量×
-- 200的数值。
--[[ __CARD_HEADER_END__ ]]

--ラヴァル・ガンナー
function c11834972.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11834972,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c11834972.condition)
	e1:SetCost(c11834972.cost)
	e1:SetOperation(c11834972.operation)
	c:RegisterEffect(e1)
end
function c11834972.cfilter(c)
	return c:IsSetCard(0x39) and not c:IsCode(11834972)
end
function c11834972.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11834972.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c11834972.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
	local ct={}
	for i=5,1,-1 do
		if Duel.IsPlayerCanDiscardDeckAsCost(tp,i) then
			table.insert(ct,i)
		end
	end
	if #ct==1 then
		Duel.DiscardDeck(tp,ct[1],REASON_COST)
	else
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11834972,1))
		local ac=Duel.AnnounceNumber(tp,table.unpack(ct))
		Duel.DiscardDeck(tp,ac,REASON_COST)
	end
	local g=Duel.GetOperatedGroup()
	e:SetLabel(g:FilterCount(Card.IsSetCard,nil,0x39)*200)
end
function c11834972.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(e:GetLabel())
		c:RegisterEffect(e1)
	end
end
