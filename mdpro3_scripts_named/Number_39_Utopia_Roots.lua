--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: No.39 希望皇 霍普·源望  (ID: 84124261)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 1
-- ATK 500 | DEF 100
-- Setcode: 276758600
--
-- Effect Text:
-- 1星怪兽×2
-- ①：自己或者对方怪兽的攻击宣言时，把这张卡1个超量素材取除才能发动。那次攻击无效，那只怪兽是超量怪兽的场合，这张卡的攻击力上升那只怪兽的阶级×500。
--[[ __CARD_HEADER_END__ ]]

--No.39 希望皇ホープ・ルーツ
function c84124261.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84124261,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c84124261.atkcost)
	e1:SetTarget(c84124261.atktg)
	e1:SetOperation(c84124261.atkop)
	c:RegisterEffect(e1)
end
aux.xyz_number[84124261]=39
function c84124261.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c84124261.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c84124261.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.NegateAttack() and tc:IsType(TYPE_XYZ) and tc:IsFaceup()
		and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetRank()*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
