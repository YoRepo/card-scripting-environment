--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: No.52 钻蟹王  (ID: 7194917)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank 4
-- ATK 0 | DEF 3000
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- ①：「No.52 钻蟹王」在自己场上只能有1只表侧表示存在。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。直到回合结束时，这张卡的守备力变成0，攻击力变成3000。
-- ③：这张卡攻击的场合，战斗阶段结束时变成守备表示。
-- ④：没有超量素材的这张卡被攻击的伤害步骤结束时变成攻击表示。
--[[ __CARD_HEADER_END__ ]]

--No.52 ダイヤモンド・クラブ・キング
function c7194917.initial_effect(c)
	c:SetUniqueOnField(1,0,7194917)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7194917,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c7194917.adcost)
	e1:SetOperation(c7194917.adop)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7194917.poscon1)
	e2:SetOperation(c7194917.posop1)
	c:RegisterEffect(e2)
	--pos
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(c7194917.poscon2)
	e3:SetOperation(c7194917.posop2)
	c:RegisterEffect(e3)
end
aux.xyz_number[7194917]=52
function c7194917.adcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c7194917.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(0)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
function c7194917.poscon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c7194917.posop1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsAttackPos() then
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	end
end
function c7194917.poscon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and e:GetHandler():GetOverlayCount()==0
end
function c7194917.posop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsDefensePos() then
		Duel.ChangePosition(c,POS_FACEUP_ATTACK)
	end
end
