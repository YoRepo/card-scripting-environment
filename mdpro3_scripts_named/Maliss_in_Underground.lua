--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 码丽丝梦游地下界  (ID: 68337209)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 447
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从自己的手卡·卡组·墓地把1张「码丽丝」卡除外。
-- ②：只要自己的除外状态的「码丽丝」陷阱卡3种类以上存在，自己场上的「码丽丝」连接怪兽的攻击力上升3000。
-- ③：只要自己场上有「码丽丝」连接怪兽存在，对方怪兽只能选择「码丽丝」连接怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--M∀LICE IN UNDERGROUND
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(s.atkcon)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.atktg)
	e2:SetValue(3000)
	c:RegisterEffect(e2)
	--limit attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(s.condition)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetValue(s.alimit)
	c:RegisterEffect(e4)
end
function s.filter(c)
	return c:IsSetCard(0x1bf) and c:IsAbleToRemove()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.filter),tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
function s.cfilter(c)
	return c:IsSetCard(0x1bf) and c:IsType(TYPE_TRAP) and c:IsFaceup()
end
function s.atkcon(e)
	local g=Duel.GetMatchingGroup(s.cfilter,e:GetHandlerPlayer(),LOCATION_REMOVED,0,nil)
	return g:GetClassCount(Card.GetCode)>=3
end
function s.atktg(e,c)
	return c:IsSetCard(0x1bf) and c:IsType(TYPE_LINK)
end
function s.cfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsSetCard(0x1bf)
end
function s.condition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(s.cfilter1,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.alimit(e,c)
	return c:IsFacedown() or not (c:IsType(TYPE_LINK) and c:IsSetCard(0x1bf))
end
