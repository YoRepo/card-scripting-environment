--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 吸血鬼女郎  (ID: 26495087)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1550 | DEF 1550
-- Setcode: 142
--
-- Effect Text:
-- 每当这张卡对对方造成战斗伤害时，宣言1个卡的种类（怪兽·魔法·陷阱），对方从其卡组中选择1张此种类的卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ヴァンパイア・レディ
function c26495087.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26495087,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c26495087.tgcon)
	e1:SetTarget(c26495087.tgtg)
	e1:SetOperation(c26495087.tgop)
	c:RegisterEffect(e1)
end
function c26495087.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c26495087.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	e:SetLabel(op)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_DECK)
end
function c26495087.tgfilter(c,ty)
	return c:IsType(ty) and c:IsAbleToGrave()
end
function c26495087.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	if e:GetLabel()==0 then g=Duel.SelectMatchingCard(1-tp,c26495087.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_MONSTER)
	elseif e:GetLabel()==1 then g=Duel.SelectMatchingCard(1-tp,c26495087.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_SPELL)
	else g=Duel.SelectMatchingCard(1-tp,c26495087.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_TRAP) end
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
