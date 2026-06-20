--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 死镰杀手  (ID: 66973070)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 8
-- ATK 2300 | DEF 1600
--
-- Effect Text:
-- ①：把这张卡以外的自己场上1只昆虫族怪兽解放才能发动。这张卡的攻击力直到回合结束时上升500。
--[[ __CARD_HEADER_END__ ]]

--デスサイズ・キラー
function c66973070.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66973070,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c66973070.atkcost)
	e1:SetOperation(c66973070.operation)
	c:RegisterEffect(e1)
end
function c66973070.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler(),RACE_INSECT) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,e:GetHandler(),RACE_INSECT)
	Duel.Release(sg,REASON_COST)
end
function c66973070.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
