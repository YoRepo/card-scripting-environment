--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Shien's Squire  (ID: 33883834)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level: 1
-- ATK 300 | DEF 700
-- Setcode: 0x20
-- Scope: OCG / TCG
--
-- Effect Text:
-- During damage calculation, if a "Six Samurai" monster you control battles (Quick Effect): You can
-- send this card from your hand to the GY; that monster cannot be destroyed by battle this turn.
--[[ __CARD_HEADER_END__ ]]

--紫炎の寄子
function c33883834.initial_effect(c)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33883834,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c33883834.con)
	e1:SetCost(c33883834.cost)
	e1:SetOperation(c33883834.op)
	c:RegisterEffect(e1)
end
function c33883834.con(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and ((a:IsControler(tp) and a:IsSetCard(0x103d)) or (d:IsControler(tp) and d:IsSetCard(0x103d)))
		and Duel.GetFlagEffect(tp,33883834)==0
end
function c33883834.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.RegisterFlagEffect(tp,33883834,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c33883834.op(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	if a:IsControler(tp) then
		a:RegisterEffect(e1)
	else
		d:RegisterEffect(e1)
	end
end
