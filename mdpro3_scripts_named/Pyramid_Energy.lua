--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 金字塔能量  (ID: 76754619)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择下面的1个效果发动。
-- ●自己的场上全部表侧表示存在的怪兽直到回合结束前攻击力上升200。
-- ●自己的场上全部表侧表示存在的怪兽直到回合结束前守备力上升500。
--[[ __CARD_HEADER_END__ ]]

--ピラミッドパワー
function c76754619.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c76754619.target)
	e1:SetOperation(c76754619.operation)
	c:RegisterEffect(e1)
end
function c76754619.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	local op=Duel.SelectOption(tp,aux.Stringid(76754619,0),aux.Stringid(76754619,1))
	e:SetLabel(op)
end
function c76754619.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	if e:GetLabel()==0 then
		local sc=g:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(200)
			sc:RegisterEffect(e1)
			sc=g:GetNext()
		end
	else
		local sc=g:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(500)
			sc:RegisterEffect(e1)
			sc=g:GetNext()
		end
	end
end
