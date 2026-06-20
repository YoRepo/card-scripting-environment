--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 未来光辉  (ID: 64107820)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己墓地存在的1只念动力族怪兽从游戏中除外发动。只要这张卡在场上存在，自己场上表侧表示存在的全部念动力族怪兽的攻击力上升因为这张卡发动而除外的怪兽的等级×200的数值。
--[[ __CARD_HEADER_END__ ]]

--フューチャー・グロウ
function c64107820.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c64107820.cost)
	e1:SetOperation(c64107820.operation)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PSYCHO))
	e2:SetValue(c64107820.val)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c64107820.cfilter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelAbove(1) and c:IsAbleToRemoveAsCost()
end
function c64107820.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64107820.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c64107820.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetLevel()*200)
	e:GetLabelObject():SetLabel(0)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c64107820.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(e:GetLabel())
end
function c64107820.val(e,c)
	return e:GetLabel()
end
