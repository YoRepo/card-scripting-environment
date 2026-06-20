--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 混沌No.9 天盖妖星 混沌戴森球  (ID: 32559361)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 10
-- ATK 3600 | DEF 3200
-- Setcode: 4168
--
-- Effect Text:
-- 10星怪兽×3
-- ①：1回合1次，自己主要阶段才能发动。给与对方这张卡的超量素材数量×300伤害。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤开始时才能发动。那只怪兽在这张卡下面重叠作为超量素材。
-- ③：这张卡有「No.9 天盖星 戴森球」在作为超量素材的场合，得到以下效果。
-- ●1回合1次，把这张卡的超量素材任意数量取除才能发动。给与对方取除数量×800伤害。
--[[ __CARD_HEADER_END__ ]]

--CNo.9 天蓋妖星カオス・ダイソン・スフィア
function c32559361.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,3)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32559361,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c32559361.target)
	e1:SetOperation(c32559361.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32559361,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c32559361.damtg)
	e2:SetOperation(c32559361.damop)
	c:RegisterEffect(e2)
	--damage2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32559361,2))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c32559361.damcon)
	e3:SetCost(c32559361.damcost)
	e3:SetTarget(c32559361.damtg2)
	e3:SetOperation(c32559361.damop2)
	c:RegisterEffect(e3)
end
aux.xyz_number[32559361]=9
function c32559361.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and c:IsType(TYPE_XYZ) and tc:IsCanOverlay() end
end
function c32559361.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToBattle() and tc:IsType(TYPE_MONSTER) and not tc:IsImmuneToEffect(e) and tc:IsCanOverlay() then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c32559361.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetOverlayCount()>0 end
	local ct=e:GetHandler():GetOverlayCount()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c32559361.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=e:GetHandler():GetOverlayCount()
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
function c32559361.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,1992816)
end
function c32559361.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local ct=e:GetHandler():RemoveOverlayCard(tp,1,99,REASON_COST)
	e:SetLabel(ct)
end
function c32559361.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*800)
end
function c32559361.damop2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=e:GetLabel()
	Duel.Damage(p,ct*800,REASON_EFFECT)
end
