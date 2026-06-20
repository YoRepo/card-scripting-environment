--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: No.51 怪腕之必杀摔角手  (ID: 56292140)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank 3
-- ATK 2600 | DEF 0
-- Setcode: 72
--
-- Effect Text:
-- 3星怪兽×3
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡进行战斗的伤害步骤结束时，把这张卡1个超量素材取除才能发动。给这张卡放置1个指示物（最多3个）。
-- ③：这张卡进行战斗的战斗阶段结束时，这张卡有3个指示物放置的场合才能发动。对方场上的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--No.51 怪腕のフィニッシュ・ホールド
function c56292140.initial_effect(c)
	c:EnableCounterPermit(0x40)
	c:SetCounterLimit(0x40,3)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,3)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56292140,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCost(c56292140.ctcost)
	e2:SetTarget(c56292140.cttg)
	e2:SetOperation(c56292140.ctop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(56292140,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c56292140.descon)
	e3:SetTarget(c56292140.destg)
	e3:SetOperation(c56292140.desop)
	c:RegisterEffect(e3)
end
aux.xyz_number[56292140]=51
function c56292140.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c56292140.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(0x40,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x40)
end
function c56292140.ctop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x40,1)
	end
end
function c56292140.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0 and e:GetHandler():GetCounter(0x40)==3
end
function c56292140.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c56292140.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
