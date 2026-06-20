--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 裁决之代行者 萨图恩  (ID: 91345518)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 6
-- ATK 2400 | DEF 0
-- Setcode: 68
--
-- Effect Text:
-- ①：把这张卡解放才能发动。自己基本分比对方多的场合，给与对方那个相差数值的伤害。这个效果在自己场上有「天空的圣域」存在的场合才能发动和处理。这个效果发动的回合，自己不能进行战斗阶段。
--[[ __CARD_HEADER_END__ ]]

--裁きの代行者 サターン
function c91345518.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91345518,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c91345518.damcost)
	e1:SetTarget(c91345518.damtg)
	e1:SetOperation(c91345518.damop)
	c:RegisterEffect(e1)
end
function c91345518.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 and e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c91345518.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)>Duel.GetLP(1-tp)
		and Duel.IsEnvironment(56433456,tp) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c91345518.damop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsEnvironment(56433456,tp) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local val=Duel.GetLP(1-p)-Duel.GetLP(p)
	if val>0 then
		Duel.Damage(p,val,REASON_EFFECT)
	end
end
